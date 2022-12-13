console.log('reply module...');

const replyService = (function(){
	function add(reply, callback, error){
		console.log('add reply ... ');
		
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data : JSON.stringify(reply),
			contentType : 'application/json; charset=utf-8',
			success: function(result, status,xhr){
				if( callback){
					callback(result);
				}			
			},
			error : function(xhr, status,er ){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function getList(param, callback, error){
	
		let page = param.page || 1;
		let bno = param.bno;
		
		$.getJSON("/replies/pages/"+bno+"/"+page,
		function(data){
			if(callback) callback(data.replyCnt, data.list);
		}).fail(function(xhr, status, err){
			if(error) error();
		});
	}
	
	function remove(rno, callback, error){
		$.ajax({
			type: 'delete',
			url: '/replies/'+rno,
			success : function(deleteResult, status, xhr){
				if(callback) callback(deleteResult);
			},
			error : function(xhr, status, er){
				if(error) error(er);
			}
		
		})
	}
	
	function update(reply, callback, error){
		console.log('RNO :' + reply.rno);
		
		$.ajax({
			type: 'put',
			url: '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : 'application/json; charset=utf-8',
			success : function(result, status, xhr){
				if(callback) callback(result);
			},
			error : function(xhr, status, er){
				if(error) error(er);
			}
		}); 
	}
	
	function get(rno, callback, error){
		$.get('/replies/'+rno, 
			function(result){
				if(callback) callback(result);
			})
		.fail(
			function(xhr, status, err){
				if(error) error();
			})
	}
	
	function displayTime(timeValue){
		let today = new Date();
		let gap = today.getTime() - timeValue;
		
		let dateObj = new Date(timeValue);
		let str = '';
		
		if(gap < (1000 * 60 * 60 * 24)){
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			
			if( hh < 10 ) hh = '0'+hh;
			if(mi < 10 ) mi = '0'+mi;
			if(ss < 10 ) ss = '0' + ss;
						
			return  hh+":"+mi+":"+ss;
		}else{
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth() + 1;
			let dd = dataObj.getDate();
			
			if( mm < 10 ) mm = '0' + mm;
			if( dd < 10 ) dd = '0' + dd;
			
			return yy+'/'+mm+'/'+dd;
		}
	}
		
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get:get,
		displayTime: displayTime
	};
})();