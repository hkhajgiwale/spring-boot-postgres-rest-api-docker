package org.restful.api.controller;

import org.restful.api.entity.Message;
import org.restful.api.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class MessageController {


    @Autowired
    MessageService messageService;

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<Message> addMessage(@RequestBody Message message) {
        messageService.saveMessage(message);
        return new ResponseEntity<Message>(message, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<Message> getMessage(@PathVariable("id") Long id) {
        Message message = messageService.getMessageById(id);
        if(message == null){
            return new ResponseEntity<Message>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<Message>(message,HttpStatus.OK);
    }

    @RequestMapping(value = "/messages", method = RequestMethod.GET)
    public ResponseEntity<List<Message>> getAllMessages(){
        List<Message> messages = messageService.getAllMessages();
        if(messages.isEmpty())
            return new ResponseEntity<List<Message>>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<List<Message>>(messages,HttpStatus.OK);
    }


}