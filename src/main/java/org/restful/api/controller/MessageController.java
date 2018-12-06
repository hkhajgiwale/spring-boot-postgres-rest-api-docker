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

    @RequestMapping(value = "/id/{id}", method = RequestMethod.GET)
    public ResponseEntity<Message> getMessage(@PathVariable("id") Long id) {
        Message message = messageService.getMessageById(id);
        if (message == null) {
            return new ResponseEntity<Message>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<Message>(message, HttpStatus.OK);
    }


    @RequestMapping(value = "/from/{message_from}", method = RequestMethod.GET)
    public ResponseEntity<List<Message>> getMessage(@PathVariable("message_from") String message_from) {
        List<Message> messages = messageService.getMessageByName(message_from);
        if (messages.isEmpty())
            return new ResponseEntity<List<Message>>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<List<Message>>(messages, HttpStatus.OK);
    }

    @RequestMapping(value = "/message/{message_description}", method = RequestMethod.GET)
    public ResponseEntity<List<Message>> getMessageByDescription(@PathVariable("message_description") String message_description){
        List<Message> messages =  messageService.getMessageByDescription(message_description);
        if(messages.isEmpty())
            return new ResponseEntity<List<Message>>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<List<Message>>(messages, HttpStatus.OK);
    }
    @RequestMapping(value = "/messages", method = RequestMethod.GET)
    public ResponseEntity<List<Message>> getAllMessages() {
        List<Message> messages = messageService.getAllMessages();
        if (messages.isEmpty())
            return new ResponseEntity<List<Message>>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<List<Message>>(messages, HttpStatus.OK);
    }

    @DeleteMapping(value = "/delete/{message_from}")
    public void deleteMessage(@PathVariable("message_from") String message_from){
        messageService.deleteByName(message_from);
    }
}