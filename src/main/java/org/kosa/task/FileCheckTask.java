package org.kosa.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.kosa.domain.BoardAttachVO;
import org.kosa.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@RequiredArgsConstructor
public class FileCheckTask {

	@Value("#{filepath['file.path']}")
	private String uploadFolder;
	private final BoardAttachMapper mapper;
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("File check Task Run -----");
		log.warn(new Date());
		
		List<BoardAttachVO> fileList = mapper.getOldFiles();
		
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get(uploadFolder,
						vo.getUploadPath(),vo.getUuid()+"_"+vo.getFileName()))
				.collect(Collectors.toList());
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get(uploadFolder, 
						vo.getUploadPath(),"_s"+vo.getUuid()+"_"+vo.getFileName()))
				.collect(Collectors.toList());
		
		log.warn("========================");
		fileListPaths.forEach(p-> log.warn(p));
		
		File targetDir = Paths.get(uploadFolder, getFolderYesterDay()).toFile();
		File[] removeFiles = targetDir.listFiles(file -> !fileListPaths.contains(file.toPath()));
		
		log.warn("--------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
}
