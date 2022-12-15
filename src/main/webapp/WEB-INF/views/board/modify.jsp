<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<meta charset="UTF-8">
<title>Modify Board</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	<h1>게시글 수정</h1>
	<form action="/board/modify" method="post">
		<div class="form-group">
			<label for="bno">Num</label> <input type="text" class="form-control"
				readonly="readonly" id="bno" name="bno"
				value="<c:out value="${board.bno }" />">
		</div>

		<div class="form-group">
			<label for="title">Title</label> <input type="text"
				class="form-control" id="title" name="title"
				value="<c:out value="${board.title }" />">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id="content" name='content' rows="3"><c:out
					value="${board.content }" /></textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> <input type="text"
				class="form-control" id="writer" name="writer"
				value="<c:out value="${board.writer }" />">
		</div>
		<div class="form-group">
			<label for="regDate">RegDate</label> <input type="text"
				readonly="readonly" class="form-control" id="regDate" name="regDate"
				value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regDate}"/>">
		</div>
		<div class="form-group">
			<label for="updateDate">UpdateDate</label> <input type="text"
				readonly="readonly" class="form-control" id="updateDate"
				name="updateDate"
				value="<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>">
		</div>
		<div>
			<h3>Files</h3>
			<div class="form-group uploadDiv">
				<input type='file' name='uploadFile' multiple='multiple'>
			</div>

			<div class="uploadResult">
				<ul>
				</ul>
			</div>
		</div>

		<button data-oper="modify" type="submit" class="btn btn-default">Modify</button>
		<button data-oper="remove" type="submit" class="btn btn-default">Remove</button>
		<button data-oper="list" type="submit" class="btn btn-default">List</button>

		<input type="hidden" name="pageNum"
			value="<c:out value="${cri.pageNum }" />" /> <input type="hidden"
			name="amount" value="<c:out value="${cri.amount }" />" /> <input
			type="hidden" name="keyword"
			value="<c:out value="${cri.keyword }" />" /> <input type="hidden"
			name="type" value="<c:out value="${cri.type }" />" />

	</form>

	<%@include file="../includes/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function(){
			let bno = '<c:out value="${board.bno}" />';
			let formObj = $('form');
			
				(function(){
					
					$.getJSON('/api/getAttachList',{bno:bno},function(arr){
						console.log(arr);
						
						let str= '';
						$(arr).each(function(i, attach){
							if(attach.fileType){
								let fileCallPath = 
									encodeURIComponent(attach.uploadPath + "/s_"+attach.uuid+"_"+attach.fileName);
								console.log(fileCallPath);
								let template = `
									<li data-path='{uploadPath}' data-uuid='{uuid}' data-filename='{filename}' data-type='{type}'>
										<div>
											<img src='/api/display?fileName={fileCallPath}'>
											<button type='button' data-file='{fileCallPath}' data-type='image'>삭제</button>
										</div>
									</li>`
									.replace('{uploadPath}',attach.uploadPath)
									.replace('{uuid}',attach.uuid)
									.replace('{filename}',attach.fileName)
									.replace('{type}',attach.fileType)
									.replaceAll('{fileCallPath}',fileCallPath);
								str+= template;
							}
						})
				
						$('.uploadResult ul').html(str);
					});
				})();
				$('.uploadResult').on('click','button',function(e){
					console.log('delete file');
					if(confirm('Remove this file? ')){
						let targetLi = $(this).closest('li');
						targetLi.remove();
					}
				})
					$('button').click(
							function(e) {
								e.preventDefault();
								let oper = $(this).data('oper');
								console.log(oper);

								if (oper == 'remove') {
									formObj.attr('action', "/board/remove");
								} else if (oper == 'list') {
									formObj.attr("action", "/board/list").attr("method", "get");
									let pageNumTag = $("input[name='pageNum']").clone();
									let amountTag = $("input[name='amount']").clone();
									let keywordTag = $("input[name='keyword']").clone();
									let typeTag = $("input[name='type']").clone();
									
									formObj.empty();
									formObj.append(pageNumTag);
									formObj.append(amountTag);
									formObj.append(keywordTag);
									formObj.append(typeTag);
								}else if(oper === 'modify'){
									console.log('submit clicked');
									let str = '';
									$('.uploadResult ul li').each(function(i,obj){
										let jobj = $(obj);
										console.log(jobj);
										
										str += `
											<input type='hidden' name='attachList[{i}].fileName' value='{filename}' >
											<input type='hidden' name='attachList[{i}].uuid' value='{uuid}' >
											<input type='hidden' name='attachList[{i}].uploadPath' value='{path}' >
											<input type='hidden' name='attachList[{i}].fileType' value='{type}' >
										`.replaceAll('{i}',i)
										.replace('{filename}',jobj.data('filename'))
										.replace('{uuid}',jobj.data('uuid'))
										.replace('{path}',jobj.data('path'))
										.replace('{type}',jobj.data('type'));
									})
									formObj.append(str);
									
								}
								formObj.submit();
							})
				})
	</script>
</body>
</html>