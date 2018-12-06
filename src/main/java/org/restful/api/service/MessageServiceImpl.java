package org.restful.api.service;

import org.restful.api.entity.Message;
import org.restful.api.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

@Service
public class  MessageServiceImpl implements MessageService{

    @Autowired
    private MessageRepository messageRepository;

    @Override
    public Message saveMessage(Message message) {

        return messageRepository.save(message);
    }

    @Override
    public Message getMessageById(Serializable id) {
        return messageRepository.getOne((Long) id);
    }

    @Override
    public List<Message> getAllMessages(){
        return messageRepository.findAll();
    }

    @Override
    public void deleteByName(Serializable message_from){
        messageRepository.deleteByName((String) message_from);
    }

    @Override
    public List<Message> getMessageByName(Serializable message_from){
        return messageRepository.getByName((String) message_from);
    }

}
