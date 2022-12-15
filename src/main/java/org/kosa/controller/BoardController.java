package org.kosa.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.kosa.domain.BoardAttachVO;
import org.kosa.domain.BoardVO;
import org.kosa.domain.Criteria;
import org.kosa.domain.PageDTO;
import org.kosa.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@RequiredArgsConstructor
@Log4j
public class BoardController {
	private String uploadFolder = "C:\\Users\\KOSA\\Desktop\\images";

	private final BoardService service;

	@GetMapping("/list")
	public String showList(Criteria cri, Model model) {
		List<BoardVO> list = service.getList(cri);
		int total = service.getTotal(cri);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "board/list";
	}

	@GetMapping("/register")
	public String showRegister() {
		return "/board/register";
	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register :" + board);
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}

	@GetMapping("/get")
	public String get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
		return "/board/get";
	}

	@GetMapping("/modify")
	public String showModify(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
		return "/board/modify";
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		return "redirect:/board/list";
		return "redirect:/board/list" + cri.getListLink();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("remove", "success");
		}
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		return "redirect:/board/list";
		return "redirect:/board/list" + cri.getListLink();
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {
		if (attachList == null || attachList.size() == 0)
			return;

		log.info("delete attach Files...");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(uploadFolder + File.separator + attach.getUploadPath() + File.separator
						+ attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(uploadFolder + File.separator + attach.getUploadPath() + File.separator
							+ "s_" + attach.getUuid() + "_" + attach.getFileName());

					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error " + e.getMessage());
			}
		});

	}

}
