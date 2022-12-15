package org.kosa.service;

import java.util.List;

import org.kosa.domain.BoardAttachVO;
import org.kosa.domain.BoardVO;
import org.kosa.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);

}
