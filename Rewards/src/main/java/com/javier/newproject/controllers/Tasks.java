package com.javier.newproject.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javier.newproject.models.Task;
import com.javier.newproject.services.RewardService;
import com.javier.newproject.services.TaskService;
import com.javier.newproject.services.UserService;

@Controller
public class Tasks {
	 
	@Autowired
	private TaskService taskService;
	private UserService userService;
	
	List<String> files = new ArrayList<String>();
	private RewardService rewardService;
	
	public Tasks (TaskService taskService, UserService userService, RewardService rewardService) {
		this.taskService = taskService;
		this.userService = userService;
		this.rewardService = rewardService;
		
	}
	
	@RequestMapping ("/tasks")
	public String showTasks (Model model, Principal principal) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		model.addAttribute("tasks", taskService.findAll());
		return "redirect:/tasks/pages/1";
	}

	@RequestMapping("/tasks/pages/{id}")
	public String tasksPages(Principal principal, Model model, @PathVariable(name="id") int pageNumber) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        Page<Task> tasks = taskService.tasksPerPage(pageNumber-1);
        model.addAttribute("totalPages", tasks.getTotalPages());
        model.addAttribute("tasks", tasks);
		return "show_all_Tasks.jsp";
	}
	
	@RequestMapping ("/tasks/add")
	public String addTasks (@ModelAttribute ("new_Task") Task task, Principal principal, Model model) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		return "add_Task.jsp";
	}
	
	@PostMapping ("/tasks/add")
	public String createTasks (@Valid @ModelAttribute ("new_Task") Task task, BindingResult result, Principal principal,
			@RequestParam("file") MultipartFile file, @RequestParam("taskReward") Long rewardId, Model model) {
		if(result.hasErrors()) {
			return "add_Task.jsp";
		} else {
			try {
				taskService.store(file);
			} catch (Exception e) {
				model.addAttribute("message", "FAIL to upload " + file.getOriginalFilename() + "!");
			}
			task.setImage(file.getOriginalFilename());
			task.setTaskReward(rewardService.findById(rewardId));
			task.setTaskCreator(userService.findByUsername(principal.getName()));
			taskService.newTask(task);
			return "redirect:/tasks";
		}
	}
	@RequestMapping ("/tasks/{id}/show")
	public String viewTask (@PathVariable("id") Long id, Model model, Principal principal) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		model.addAttribute("task", taskService.findById(id));
		System.out.println(taskService.findById(id).getTaskCreator());
		return "show_Task.jsp";
	}
	
	@RequestMapping("/file/download/{filename}")
	@ResponseBody
	public ResponseEntity<Resource> getFile(@PathVariable String filename) {
		Resource file = taskService.loadFile(filename);
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
				.body(file);
	}
	
	@RequestMapping ("/tasks/{id}/edit")
	public String editTask (@ModelAttribute ("task") Task task, @PathVariable("id") Long id, Principal principal, Model model) {
		if (userService.findByUsername(principal.getName()) == taskService.findById(id).getTaskCreator() || userService.findByUsername(principal.getName()).getLevel() < 3) {
			model.addAttribute("task", taskService.findById(id));
			model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
			return "edit_Task.jsp";
		} else {
			return "redirect:/tasks";
		}
	}
	
	@PostMapping ("/tasks/{id}/edit")
	public String updateTask (@Valid @ModelAttribute("task") Task task, BindingResult result, @PathVariable("id") Long id, Principal principal, Model model) {
		if (result.hasErrors()) {
			return "edit_Task.jsp";
		} else {
			taskService.updateTask(task);
			return "redirect/tasks";
		}
	}
	
	@RequestMapping ("/tasks/{id}/cancel")
	public String cancelTask (@PathVariable("id") Long id, Principal principal) {
		if (userService.findByUsername(principal.getName()) == taskService.findById(id).getTaskCreator() || userService.findByUsername(principal.getName()).getLevel() < 3) {
			Task task = taskService.findById(id);
			taskService.cancelTask(task);
			return "redirect:/tasks";
		} else {
			return "redirect:/tasks";
		}
	}
	
	@RequestMapping("/dashboard/pages/{id}")
	public String dashboard(Principal principal, Model model, @PathVariable(name="id") int pageNumber) {
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
        Page<Task> tasks = taskService.tasksPerPage(pageNumber-1);
        model.addAttribute("totalPages", tasks.getTotalPages());
        model.addAttribute("tasks", tasks);
		return "dashboard.jsp";
	}
}
