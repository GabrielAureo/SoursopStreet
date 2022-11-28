public class DialogueData
{
    public string? Name { get; private set; }
    public string Dialogue { get; private set; }

    public DialogueData(string dialogue)
    {
        this.Dialogue = dialogue;
    }

    public DialogueData(string name, string dialogue)
    {
        this.Name = name;
        this.Dialogue = dialogue;
    }
}