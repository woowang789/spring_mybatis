package org.kosa.security;

import org.kosa.domain.CustomUser;
import org.kosa.domain.MemberVO;
import org.kosa.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		log.warn("Load User By UserName : "+ userName);
		
		MemberVO vo = memberMapper.read(userName);
		
		log.warn("queried by member mapper : "+ vo);
		return vo == null ? null : new CustomUser(vo);
	}

	
}
