using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class DialoguePanel : MonoBehaviour, IPointerClickHandler
{
    private Action pointerAction;

    public void RegisterPointerCallback(Action pointerAction)
    {
        this.pointerAction = pointerAction;
    }
    public void OnPointerClick(PointerEventData eventData)
    {
        pointerAction?.Invoke();
    }
}