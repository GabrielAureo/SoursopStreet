using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using Ink.Runtime;

public class StoryManager : MonoBehaviour
{


    [SerializeField] private TextAsset inkJSONAsset = null;
    private Story story;

    private void Start()
    {
        StartStory();
    }

    public void StartStory()
    {
        story = new Story(inkJSONAsset.text);
        NextDialogue();
    }

    public DialogueData NextDialogue()
    {
        if (!story.canContinue) return null;

        string text = story.Continue();

        return parseLine(text);



    }

    private DialogueData parseLine(string text)
    {
        text = text.Trim();
        var parsedString = text.Split(':');
        if (parsedString.Length > 1)
        {
            var name = parsedString[0];
            var dialogue = parsedString[1];
            return new DialogueData(name, dialogue);
        }
        else
        {
            var dialogue = parsedString[0];
            return new DialogueData(dialogue);
        }
    }



}
