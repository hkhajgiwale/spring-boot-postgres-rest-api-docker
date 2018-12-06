package org.restful.api.repository;

import org.restful.api.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {

@Query(value = "SELECT m FROM Message m WHERE m.messageFrom LIKE :message_from")
List<Message> getByName(@Param("message_from")String message_from);



@Transactional
@Modifying
@Query(value = "DELETE FROM Message m WHERE m.messageFrom LIKE :message_from")
    void deleteByName(@Param("message_from")String message_from);
}