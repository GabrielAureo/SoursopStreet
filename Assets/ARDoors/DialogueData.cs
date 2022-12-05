using System;

public class DialogueData
{

    public class Choice
    {
        public string Label;
        public Action OnSelect;
    }

    public enum StoryPhase { READING, MOVING, MAKING_CHOICE }

    public string Name { get; set; }
    public string Dialogue { get; set; }
    public Choice[] Choices { get; set; }
    public StoryPhase Phase { get; set; }
    public string RoomId { get; set; }

    public override string ToString()
    {
        return $"{this.Name}\n{this.Dialogue}\n{this.Phase}";
    }

}