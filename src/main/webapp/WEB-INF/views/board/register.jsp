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
	<form action="/board/register" method="post">
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
			<label for="uplaodFile">uplaodFile</label> <input type="file"
				class="form-control" id="uplaodFile" name="uplaodFile">
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
		$('button[type="submit"]').click(function(e){
			e.preventDefault();
			console.log("submit clicked");
		})
		
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
		
		$("input[type='file']").change(function(e){
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			for(let i=0;i<files.length;i++){
				if(!checkExtension(files[i].name, files[i].size)) return false;
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData:false,
				contentType : false,
				data : formData,
				type: 'POST',
				dataType : 'json',
				success : function(result){
					console.log(result);
				}
			})
		});
	})
	</script>
</body>
</html>