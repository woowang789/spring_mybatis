package org.kosa.mapper;

import org.kosa.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userId);
}
