using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DialogueUIController : MonoBehaviour
{
    [SerializeField] private DialoguePanel dialoguePanel;
    [SerializeField] private TextMeshProUGUI dialogueText;
    [SerializeField] private TextMeshProUGUI nameText;

    private void Awake()
    {
        dialoguePanel.RegisterPointerCallback(OnPanelTap);

    }

    private void OnPanelTap()
    {
        var data = GameManager.Instance.StoryManager.NextDialogue();
        SetDialogueUI(data);
    }

    private void SetDialogueUI(DialogueData data)
    {
        dialogueText.text = data.Dialogue;
        nameText.text = data.Name;
    }
}