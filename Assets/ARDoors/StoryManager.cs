using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using Ink.Runtime;
using UnityEngine.Events;

public class StoryManager : MonoBehaviour
{
    [SerializeField] private TextAsset inkJSONAsset = null;
    private Story story;
    public DialogueData data { get; private set; } = new DialogueData();
    public UnityEvent<string> OnDialogueFinished { get; private set; } = new UnityEvent<string>();

    private void Awake()
    {
        if (!story) StartStory();
    }

    public void StartStory()
    {
        story = new Story(inkJSONAsset.text);
        NextDialogue();
    }

    private bool isOnStreet()
    {
        return story.currentTags.Contains("movement_choice");
    }

    public bool PickRoomDialogue(string roomId)
    {
        var isMoving = data.Phase == DialogueData.StoryPhase.MOVING;
        if (isMoving)
        {
            var roomIndex = GameManager.Instance.RoomData.GetRoomIndex(roomId);
            story.ChooseChoiceIndex(roomIndex);
            NextDialogue();
            data.RoomId = roomId;
        }

        return isMoving;

    }

    public void NextDialogue()
    {
        if (!story.canContinue) return;
        parseLine();
    }

    private void parseLine()
    {
        string text = story.Continue();
        text = text.Trim();
        var parsedString = text.Split(':');

        string dialogue = "";
        if (parsedString.Length > 1)
        {
            var name = parsedString[0];
            dialogue = parsedString[1];
            data.Name = name;
        }
        else
            dialogue = parsedString[0];

        data.Dialogue = dialogue.Trim();

        var choiceList = new List<DialogueData.Choice>();
        foreach (var choice in story.currentChoices)
            choiceList.Add(new DialogueData.Choice()
            {
                Label = choice.text.Trim(),
                OnSelect = delegate
                {
                    story.ChooseChoiceIndex(choice.index);
                },

            });

        data.Choices = choiceList.ToArray();

        if (data.Choices.Length > 0)
            if (isOnStreet())
                FinishCurrentDialogue();
            else
                data.Phase = DialogueData.StoryPhase.MAKING_CHOICE;
        else
            data.Phase = DialogueData.StoryPhase.READING;
    }

    private void FinishCurrentDialogue()
    {
        data.Phase = DialogueData.StoryPhase.MOVING;
        OnDialogueFinished.Invoke(data.RoomId);
    }



}
