<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<meta charset="UTF-8">
<title>Regist Board</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>게시글 등록</h1>
	<form role='form' action="/board/register" method="post">
		<div class="form-group">
			<label for="title">Title</label> <input type="text"
				class="form-control" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id="content" name='content' rows="3"></textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> <input type="text"
				class="form-control" id="writer" name="writer">
		</div>
		<div class="form-group">
			<label for="uploadFile">uplaodFile</label> <input type="file"
				class="form-control" id="uploadFile" name="uploadFile" multiple="multiple">
		</div>
		
		<div class="uploadResult">
			<ul>
			</ul>
		</div>

		<button type="submit" class="btn btn-default">Submit</button>
		<button type="button" class="btn btn-default">Reset</button>

	</form>

	<%@include file="../includes/footer.jsp"%>
	
	<script>
	$(document).ready(function(){
		const formObj = $("form[role='form']");
		const uploadUL = $(".uploadResult ul");
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			console.log("submit clicked");
			
			let str = '';
			$('.uploadResult ul li').each(function(i, obj){
				let jobj = $(obj);
				console.dir(jobj);
				
				let template = `
				<input type='hidden' name='attachList[{i}].fileName' value='{fileName}'>
				<input type='hidden' name='attachList[{i}].uuid' value='{uuid}'>
				<input type='hidden' name='attachList[{i}].uploadPath' value='{uploadPath}'>
				<input type='hidden' name='attachList[{i}].fileType' value='{fileType}'>
				`
					.replaceAll('{i}',i)
					.replace('{fileName}',jobj.data('filename'))
					.replace('{uuid}',jobj.data('uuid'))
					.replace('{uploadPath}',jobj.data('path'))
					.replace('{fileType}',jobj.data('type'))
					;
				console.log(template);
				
				str+= template;
			})
			formObj.append(str);
			formObj.submit();
		})	
		
		uploadUL.on("click","button",function(e){
			console.log('delete file');
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			
			let targetLi = $(this).closest("li");
			
			console.log('targetFile : '+ targetFile);
			
			$.ajax({
				url: '/api/deleteFile',
				data : {fileName: targetFile, type: type},
				dataType: 'text',
				type : 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
			})
			
		});
		
		const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		const maxSize = 5242880;
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.")
				return false;
			}
			return true;
		}
		
		function showUploadedFile(uploadResultArr){
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				if(!obj.image){
					// 이미지가 아니면 .. 
				}else{
					let fileCallPath = encodeURIComponent(
							obj.uploadPath + "/s_"+obj.uuid+"_"+obj.fileName);
					str += 
					`<li data-path='{uploadPath}' data-uuid='{uuid}' data-filename='{filename}' data-type='{type}'>
						<img src='/api/display?fileName={fileCallPath}'>
						<button type="button" data-type="image" data-file='{fileCallPath}'>삭제</button>		
					</li>`
						.replaceAll('{fileCallPath}',fileCallPath)
						.replace('{uploadPath}', obj.uploadPath)
						.replace('{uuid}',obj.uuid)
						.replace('{type}',obj.image)
						.replace('{filename}',obj.fileName)
					;
				}
			});
			uploadUL.append(str);
		}
		
		$("input[type='file']").change(function(e){
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			for(let i=0;i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size)) return false;
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url: '/api/uploadAjaxAction',
				processData:false,
				contentType : false,
				data : formData,
				type: 'POST',
				dataType : 'json',
				success : function(result){
					console.log(result);
					showUploadedFile(result);
				}
			});
		});
	})
	</script>
</body>
</html>