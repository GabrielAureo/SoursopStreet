using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class RoomController : MonoBehaviour
{
    [SerializeField] private string roomId;
    [SerializeField] private DoorController doorController;

    private void Awake()
    {
        doorController.OnDoorOpen.AddListener(StartRoomDialogue);
        GameManager.Instance.StoryManager.OnDialogueFinished.AddListener(OnDialogueFinished);
    }

    private void StartRoomDialogue()
    {
        GameManager.Instance.StoryManager.PickRoomDialogue(roomId);
    }

    private void OnDialogueFinished(string roomId)
    {
        if (roomId == this.roomId)
            doorController.Close();
    }
}
