using System;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class ChoiceController : MonoBehaviour
{
    private Button button;
    private TextMeshProUGUI textMesh;

    private void Awake()
    {
        button = GetComponentInChildren<Button>();
        textMesh = GetComponentInChildren<TextMeshProUGUI>();
    }

    public void Set(string choiceText, Action onSelect)
    {
        button.onClick.AddListener(delegate { onSelect(); });
        textMesh.text = choiceText;
    }
}