package org.restful.api.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.springframework.stereotype.Controller;

import javax.persistence.*;

@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "messages", catalog = "messages_api" , schema = "public")
public class Message implements java.io.Serializable {
    private static final long serialVersionUID = 4910225916550731446L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private Long id;

    @Column(name = "message_description", length = 50)
    private String messageDescription;

    @Column(name = "message_from", length = 50)
    private String messageFrom;

    @Column(name = "is_palindrome")
    private boolean palindrome;

    public Message(){

    }

    public Message(Long id){
        this.id = id;
    }

    public Long getId() {

        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMessageDescription() {
        return messageDescription;
    }

    public void setMessageDescription(String messageDescription) {
        this.messageDescription = messageDescription;
    }

    public String getMessageFrom() {
        return messageFrom;
    }

    public void setMessageFrom(String messageFrom) {
        this.messageFrom = messageFrom;
    }

    public boolean isPalindrome(){
        return this.palindrome;
    }

    public void setPalindrome(boolean palindrome){
        this.palindrome = palindrome;
    }

    public Message(String messageDescription, String messageFrom){
        this.messageDescription = messageDescription;
        this.messageFrom = messageFrom;
    }


}