<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../includes/import.jsp"%>
<style>
span {
	display: inline-block;
	width: 100px;
	font-weight: bold;
	width: 100px;
}
</style>
<meta charset="UTF-8">
<title>Get Page</title>
</head>
<body>

	<%@include file="../includes/header.jsp"%>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">New Reply</h5>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="reply" class="col-form-label">Reply</label> <input
								type="text" class="form-control" id="reply" name="reply">
						</div>
						<div class="form-group">
							<label for="replery" class="col-form-label">Replyer</label> <input
								type="text" class="form-control" id="replyer" name="replery">
						</div>
						<div class="form-group">
							<label for="replyDate" class="col-form-label">ReplyDate</label> <input
								type="text" class="form-control" id="replyDate" name="replyDate">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button id='modalCloseBtn' type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id='modalModBtn' type="button" class="btn btn-primary"
						data-dismiss="modal">Modify</button>
					<button id='modalCreateBtn' type="button" class="btn btn-primary"
						data-dismiss="modal">Create</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-primary"
						data-dismiss="modal">Remove</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<span>Num</span>
		<c:out value="${board.bno }" />
	</div>
	<div>
		<span>Title</span>
		<c:out value="${board.title }" />
	</div>
	<div>
		<span>Content</span>
		<c:out value="${board.content }" />
	</div>
	<div>
		<span>Writer</span>
		<c:out value="${board.writer }" />
	</div>
	<div>
		<span>RegDate</span>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }" />
	</div>
	<div>
		<span>UpdateDate</span>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" />
	</div>

	<button id='addReplyBtn' type="button" class="btn btn-primary"
		data-toggle="modal" data-target="#exampleModal">New Reply</button>
	<button data-oper="modify" type="submit" class="btn btn-default">Modify</button>
	<button data-oper="list" type="submit" class="btn btn-default">List</button>

	<div>
		<h3>Replies</h3>
		<ul class="chat">
			<li class="left clearifx" data-rno="12">
				<div class="header">
					<strong class="primary-font">user00</strong> <small
						class="pull-right text-muted">2018-01-01 13:13</small>
				</div>
				<p>Good job!</p>
			</li>
		</ul>
	</div>


	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" readonly="readonly"
			value="<c:out value="${board.bno }" />" /> <input type="hidden"
			name="pageNum" value="<c:out value="${cri.pageNum }" />" /> <input
			type="hidden" name="amount" value="<c:out value="${cri.amount }" />" />
		<input type="hidden" name="keyword"
			value="<c:out value="${cri.keyword }" />" /> <input type="hidden"
			name="type" value="<c:out value="${cri.type }" />" />
	</form>


	<%@include file="../includes/footer.jsp"%>

	<script src="/resources/js/reply.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			let operForm = $("#operForm");

			$('button[data-oper="modify"]').click(function(e) {
				operForm.attr("action", "/board/modify").submit();

			});
			$('button[data-oper="list"]').click(function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list");
				operForm.submit();
			});

			
			let bnoValue = '<c:out value="${board.bno}" />';
			let replyUL = $('.chat')
			showList(1);
			
			const baseReply = `
			<li class="left clearifx" data-rno="{rno}">
				<div class="header">
					<strong class="primary-font">{replyer}</strong>
					<small class="pull-right text-muted">{replyDate}</small>
				</div>
				<p>{reply}</p>
			</li>
			`
			
			function showList(page){
				replyService.getList({bno:bnoValue,page:page||1}, function(list){
					let str = '';
					if(list == null || list.length == 0) {
						replyUL.html("");
						return;
					}
					for(let i=0,len = list.length ||0 ; i<len ;i++){
						str += baseReply.replace('{rno}',list[i].rno)
							.replace('{replyer}',list[i].replyer)
							.replace('{replyDate}', replyService.displayTime(list[i].replyDate))
							.replace('{reply}',list[i].reply);
					}
					replyUL.html(str);
				})
			}
			
			let modal = $('.modal');
			let modalInputReply = modal.find('input[name="reply"]')
			let modalInputReplyer = modal.find('input[name="replyer"]')
			let modalInputReplyDate = modal.find('input[name="replyDate"]')
			
			let modalModBtn = $('#modalModBtn');
			let modalRemoveBtn = $('#modalRemoveBtn');
			let modalRegisterBtn = ${'#modalCreateBtn'}
		});
	/* 	
		console.log(replyService)
		let bnoValue = '<c:out value="${board.bno}" />';
		replyService.add({
			reply : "JS Test",
			replyer : "tester",
			bno : bnoValue
		}, function(result) {
			alert("Result :" + result);
		});
		
		replyService.getList({bno:bnoValue, page:1}, function(list){
			for(let i=0; len = list.length||0, i < len; i++){
				console.log(list[i]);
			}
		})
		
		replyService.remove(13, 
			function(count){
				console.log(count);
				
				if(count == 'success') alert('removed');
		}, 
			function(err){
				alert('error');
			}
		)
		
		replyService.update({
			rno:14,
			bno: bnoValue,
			reply : "Modify Reply ... "
		}, function(result){
			alert('수정 완료..')
		})
		
		replyService.get(18, function(data){
			console.log('ttt');
			console.log(data);
		}) 
		*/
	</script>
</body>
</html>