using System.Collections;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DialogueUIController : MonoBehaviour
{
    private enum WritingPhase
    {
        BEGUN, WRITING, FINISHED
    }
    [SerializeField] private DialoguePanel dialoguePanel;
    [SerializeField] private TextMeshProUGUI dialogueText;
    [SerializeField] private TextMeshProUGUI nameText;
    [SerializeField] private RectTransform choicesView;
    [SerializeField] private GameObject choicePrefab;

    [SerializeField]
    private float messageTypewriteIntervalInSeconds;
    private bool choicesChanged;


    private string writingMessage;
    private string typewriterTarget;
    private WritingPhase typewritingPhase = WritingPhase.FINISHED;
    private Coroutine typeWriter;


    private StoryManager storyManager
    {
        get
        {
            return GameManager.Instance.StoryManager;
        }
    }

    private void Awake()
    {
        dialoguePanel.RegisterPointerCallback(OnPanelTap);
        StartCoroutine(TypewriteMessage());

    }

    private void Update()
    {
        if (typewriterTarget != storyManager.data.Dialogue)
        {
            typewritingPhase = WritingPhase.BEGUN;
            typewriterTarget = storyManager.data.Dialogue;
            if (typeWriter != null)
                StopCoroutine(typeWriter);
        }
        if (typewritingPhase == WritingPhase.BEGUN)
            typeWriter = StartCoroutine(TypewriteMessage());

        if (storyManager.data.Phase != DialogueData.StoryPhase.MOVING)
            SetDialogueUI(storyManager.data);
        else
            dialoguePanel.gameObject.SetActive(false);
    }

    private void OnPanelTap()
    {
        if (typewritingPhase == WritingPhase.WRITING)
            SkipToMessageEnd();
        else
            NextDialogue();
    }

    private void SkipToMessageEnd()
    {
        WriteDialogue(storyManager.data.Dialogue);
        if (typeWriter != null)
            StopCoroutine(typeWriter);
    }

    private float lastWriteTime;
    private IEnumerator TypewriteMessage()
    {
        writingMessage = "";
        Debug.Log(storyManager.data.Dialogue);
        foreach (var c in storyManager.data.Dialogue)
        {
            typewritingPhase = WritingPhase.WRITING;
            WriteDialogue(writingMessage + c);
            yield return new WaitForSecondsRealtime(messageTypewriteIntervalInSeconds);
        }
    }

    private void WriteDialogue(string nextMessage)
    {

        writingMessage = nextMessage;
        if (writingMessage.Equals(storyManager.data.Dialogue))
        {
            typewritingPhase = WritingPhase.FINISHED;
        }

    }

    private void NextDialogue()
    {
        storyManager.NextDialogue();
    }

    private void SetDialogueUI(DialogueData data)
    {
        dialoguePanel.gameObject.SetActive(true);
        if (data.Choices.Length == 0 && choicesChanged)
        {
            foreach (Transform child in choicesView.transform)
            {
                GameObject.Destroy(child.gameObject);
            }
            choicesChanged = false;
        }

        dialogueText.text = writingMessage;
        nameText.text = data.Name;
        if (!choicesChanged && data.Choices.Length > 0)
        {
            SetChoices(data.Choices);
            choicesChanged = true;
        }
    }

    private void SetChoices(DialogueData.Choice[] choices)
    {
        foreach (var choice in choices)
        {
            var choiceObj = Instantiate(choicePrefab, choicesView);
            var choiceController = choiceObj.GetComponent<ChoiceController>();
            choice.OnSelect += delegate { NextDialogue(); };
            choiceController.Set(choice.Label, choice.OnSelect);

        }
    }
}