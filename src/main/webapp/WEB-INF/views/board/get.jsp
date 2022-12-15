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

	<div class='bigPictureWrapper'>
		<div class='bigPicture'></div>
	</div>
	<style>
		.bigPictureWrapper{
			position : absolute;
		}
	</style>

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
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
							<label for="replyer" class="col-form-label">Replyer</label> <input
								type="text" class="form-control" id="replyer" name="replyer">
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
		data-toggle="modal">New Reply</button>
	<button data-oper="modify" type="submit" class="btn btn-default">Modify</button>
	<button data-oper="list" type="submit" class="btn btn-default">List</button>

	<div>
		<h3>Files</h3>
		<div class="uploadResult">
			<ul>
			</ul>
		</div>		
	</div>

	<div>
		<h3>Replies</h3>
		<ul class="chat">
		</ul>
	</div>


	<div class="panel-footer"></div>


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
			let bno = '<c:out value="${board.bno}" />';
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
								</div>
							</li>`
							.replace('{uploadPath}',attach.uploadPath)
							.replace('{uuid}',attach.uuid)
							.replace('{filename}',attach.fileName)
							.replace('{type}',attach.fileType)
							.replace('{fileCallPath}',fileCallPath);
							console.log(template);
						str+= template;
					}
				})
				$('.uploadResult ul').html(str);
			});
			
			$('.uploadResult').on('click','li',function(e){
				console.log('view image');
				
				let liObj = $(this);
				
				let path = 
					encodeURIComponent(liObj.data('path')+'/'+liObj.data('uuid')+'_'+liObj.data('filename'));
				
				if(liObj.data('type')) showImage(path.replace(new RegExp(/\\/g),"/"));
			});
			
			function showImage(fileCallPath){
				alert(fileCallPath);
				$('.bigPictureWrapper').css('display','flex').show();
				
				let template = `<img src='/api/display?fileName={fileCallPath}'>`
						.replace('{fileCallPath}',fileCallPath);
				$(".bigPicture").html(template).animate({width:'100%', height:'100%'}, 1000);
			}
			$('.bigPictureWrapper').click(function(e){
				$('.bigPicture').animate({width:'0%', height:'0%'},1000);
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				},1000);
			});
			
			
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
				replyService.getList({bno:bnoValue,page:page||1}, function(replyCnt, list){
					console.log(replyCnt);
					console.log(list);
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
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
					showReplyPage(replyCnt);
				})
			}
			
			/* reply modal */
			
			let modal = $('.modal');
			let modalInputReply = modal.find('input[name="reply"]')
			let modalInputReplyer = modal.find('input[name="replyer"]')
			let modalInputReplyDate = modal.find('input[name="replyDate"]')
			
			let modalModBtn = $('#modalModBtn');
			let modalRemoveBtn = $('#modalRemoveBtn');
			let modalRegisterBtn = $('#modalCreateBtn');
			
			/* reply paging */
			let pageNum = 1;
			let replyPageFooter = $('.panel-footer');
			
			$('#addReplyBtn').click(function(e){
				modal.find('input').val('');
				modalInputReplyDate.closest('div').hide();
				modal.find('button[id!="modalCloseBtn"]').hide();
				
				modalRegisterBtn.show();
				
				modal.modal("show");
				
			})
			
			modalRegisterBtn.click(function(e){
				let reply = {
						reply : modalInputReply.val(),
						replyer : modalInputReplyer.val(),
						bno : bnoValue
				};
				replyService.add(reply, function(result){
					alert(result);
					
					modal.find('input').val('');
					modal.modal('hide');
					
					showList(-1);
				})
			})
			
			$('.chat').on('click','li',function(e){
				let rno = $(this).data('rno');
				
				replyService.get(rno, function(reply){
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr('readonly','readonly');
					modal.data('rno', reply.rno);
					
					modal.find('button[id!="modalCloseBtn"]').hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					modal.modal('show');
				})
			})
			
			modalModBtn.click(function(e){
				let reply = {rno : modal.data('rno'), reply:modalInputReply.val()};
				replyService.update(reply, function(result){
					alert(result);
					modal.modal('hide');
					showList(pageNum);
				})
			})
			
			modalRemoveBtn.click(function(e){
				let rno = modal.data('rno');
				replyService.remove(rno, function(result){
					alert(result);
					modal.modal('hide');
					showList(pageNum);
				})
			})
			
			function showReplyPage(replyCnt){
				let endNum = Math.ceil(pageNum / 10.0) * 10;
				let startNum = endNum - 9;
				
				let prev = startNum != 1;
				let next = false;
				
				if(endNum * 10 >= replyCnt){
					endNum = Math.ceil(replyCnt/10.0);
				}
				if(endNum * 10 < replyCnt){
					next = true;
				}
				
				let str = `<ul class='pagination pull-right'>`;
				
				let prevUL = `
					<li class='page-item'>
						<a class='page-link' href='{num}'>Previous</a>
					</li>`;
				let nextUL = `
					<li class='page-item'>
					<a class='page-link' href='{num}'>Next</a>
				</li>`;
				let numUL = `
					<li class='page-item {active}'>
						<a class='page-link' href='{num}'>{num}</a>
					</li>
				`;
				
				if(prev) str+= prevUL.replace('{num}', startNum-1);
				
				for(let i=startNum; i<= endNum; i++){
					let active = pageNum == i? "active":"";
					str+= numUL.replaceAll('{num}', i).replace('{active}',active);
				}
				if(next) str += nextUL.replace('{num}', endNum+1);
				str += "</ul>"
				
				console.log(str);
				replyPageFooter.html(str);
			}
			
			replyPageFooter.on('click','li a',function(e){
				e.preventDefault();
				console.log('page click');
				
				let targetPageNum = $(this).attr('href');
				console.log('targetPageNum : '+ targetPageNum);
				pageNum = targetPageNum;
				
				showList(pageNum);
			})
		})
	</script>
</body>
</html>