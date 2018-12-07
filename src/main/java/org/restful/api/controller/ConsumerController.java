package org.restful.api.controller;

import org.restful.api.entity.Message;
import org.restful.api.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

@Controller
public class ConsumerController {
    @Autowired
    MessageService messageService;

    @RequestMapping("/showMessages")
    public ModelAndView showMessages() {
        List<Message> messages = messageService.getAllMessages();
        return new ModelAndView("showMessages", "messages",messages);
    }

    @GetMapping("/addMessage")
    public String addMessageForm(Model model) {
        model.addAttribute("message", new Message());
        return "addMessage";
    }

    @PostMapping("/showMessage")
    public String messageSubmit(@ModelAttribute Message message) {

        messageService.saveMessage(message);
        return "showMessage";
    }

}
