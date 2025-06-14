package Model;

import java.sql.Date;
import java.time.LocalDateTime;

public class FaqAnswer {

    private int answerId;
    private FaqQuestion question;
    private String content;
   private Date createdAt;
private Date updatedAt;


    public FaqAnswer() {
    }

    public FaqAnswer(int answerId, FaqQuestion question, String content, Date createdAt, Date updatedAt) {
        this.answerId = answerId;
        this.question = question;
        this.content = content;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

   

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public FaqQuestion getQuestion() {
        return question;
    }

    public void setQuestion(FaqQuestion question) {
        this.question = question;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    

    @Override
    public String toString() {
        return "FaqAnswer{" + "answerId=" + answerId + ", question=" + question + ", content=" + content + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

}
