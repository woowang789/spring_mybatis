package org.kosa.service;

import java.util.List;

import org.kosa.domain.Criteria;
import org.kosa.domain.ReplyPageDTO;
import org.kosa.domain.ReplyVO;
import org.kosa.mapper.BoardMapper;
import org.kosa.mapper.ReplyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	private final ReplyMapper replyMapper;
	private final BoardMapper boardmapper;

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		boardmapper.updateReplyCnt(vo.getBno(), 1);
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return replyMapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		ReplyVO vo = replyMapper.read(rno);
		boardmapper.updateReplyCnt(vo.getBno(), -1);
		return replyMapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return replyMapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(replyMapper.getCountByBno(bno), replyMapper.getListWithPaging(cri, bno));
	}

}
