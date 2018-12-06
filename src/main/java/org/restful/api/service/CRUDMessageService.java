package org.restful.api.service;

import org.springframework.data.jpa.repository.Query;

import java.io.Serializable;
import java.util.List;

public interface CRUDMessageService<E>{
    E saveMessage(E message);
    E getMessageById(Serializable id);
    List<E> getAllMessages();
    List<E> getMessageByName(Serializable message_from);
    List<E> getMessageByDescription(Serializable message_description);
    void deleteByName(Serializable message_from);
}