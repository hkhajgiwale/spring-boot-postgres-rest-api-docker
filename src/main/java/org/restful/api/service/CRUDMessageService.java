package org.restful.api.service;

import java.io.Serializable;
import java.util.List;

public interface CRUDMessageService<E>{
    E saveMessage(E message);
    E getMessageById(Serializable id);
    List<E> getAllMessages();
    void delete(Serializable id);
}