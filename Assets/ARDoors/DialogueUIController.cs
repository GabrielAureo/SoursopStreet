using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DialogueUIController : MonoBehaviour
{
    [SerializeField] private DialoguePanel dialoguePanel;
    [SerializeField] private TextMeshProUGUI dialogueText;
    [SerializeField] private TextMeshProUGUI nameText;
    [SerializeField] private RectTransform choicesView;
    [SerializeField] private GameObject choicePrefab;

    private bool choicesChanged;

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

    }

    private void Update()
    {
        if (storyManager.data.Phase != DialogueData.StoryPhase.MOVING)
            SetDialogueUI(storyManager.data);
        else
            dialoguePanel.gameObject.SetActive(false);
    }

    private void OnPanelTap()
    {
        NextDialogue();
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

        dialogueText.text = data.Dialogue;
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