package org.kosa.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosa.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_= @Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("new title");
		board.setContent("test content");
		board.setWriter("service writer");
		
		service.register(board);
		
		log.info(board.getBno()+" 번의 게시물 생성됨");
	}
	
	@Test
	public void testGetList() {
		service.getList().forEach(b-> log.info(b));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(22L));
	}
	
	@Test
	public void testModify() {
		BoardVO board = service.get(22L);
		
		if(board == null) return;
		board.setTitle("edit title2");
		log.info(service.modify(board));
		log.info(service.get(22L));
	}
	
}
