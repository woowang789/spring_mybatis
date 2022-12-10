package org.kosa.service;

import java.util.List;

import org.kosa.domain.BoardVO;
import org.kosa.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	private final BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}
	
	

}
