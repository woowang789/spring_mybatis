package org.kosa.service;

import java.util.List;

import org.kosa.domain.BoardAttachVO;
import org.kosa.domain.BoardVO;
import org.kosa.domain.Criteria;
import org.kosa.mapper.BoardAttachMapper;
import org.kosa.mapper.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	private final BoardMapper boardMapper;
	private final BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		boardMapper.insertSelectKey(board);
		if(board.getAttachList() == null || board.getAttachList().size() ==0) return;
		
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		System.out.println(board.getAttachList()+"-------------------------------------");
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = boardMapper.update(board)==1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Override
	public boolean remove(Long bno) {
		attachMapper.deleteAll(bno);
		return boardMapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		
//		return mapper.getList();
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		return attachMapper.findByBno(bno);
	}
	
	
	

}
