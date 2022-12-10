package org.kosa.controller;

import java.util.List;

import org.kosa.domain.BoardVO;
import org.kosa.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@RequiredArgsConstructor
@Log4j
public class BoardController {
	
	private final BoardService service;
	
	@GetMapping("/list")
	public String showList(Model model) {
		List<BoardVO> list =  service.getList();
		model.addAttribute("list",list);
		
		log.info(list);
		
		return "board/list";
	}
	
}
