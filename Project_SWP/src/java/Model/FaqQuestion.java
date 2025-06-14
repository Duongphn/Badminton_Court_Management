package Model;

import java.time.LocalDateTime;

public class FaqQuestion {
    private int questionId;
    private String title;
    private FaqTag tag;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public FaqQuestion() {
    }

    public FaqQuestion(int questionId, String title, FaqTag tag, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.questionId = questionId;
        this.title = title;
        this.tag = tag;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public FaqTag getTag() {
        return tag;
    }

    public void setTag(FaqTag tag) {
        this.tag = tag;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "FaqQuestion{" + "questionId=" + questionId + ", title=" + title + ", tag=" + tag + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
}
