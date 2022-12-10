package org.kosa.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kosa.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;

	@Test
	public void testGetList() {
		mapper.getList().forEach(b -> log.info(b));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("test new title");
		board.setContent("test new content");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("test new title");
		board.setContent("test new content");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read(22L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(1L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = mapper.read(22L);
		board.setContent("edit content");
		board.setTitle("edit title");
		board.setWriter("edit writer");
		
		int count = mapper.update(board);
		
		log.info(count);
		
	}

}
