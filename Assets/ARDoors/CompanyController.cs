using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CompanyController : MonoBehaviour, ARInteractable
{
    private const string roomId = "delivery_company";


    private void StartRoomDialogue()
    {
        GameManager.Instance.StoryManager.PickRoomDialogue(roomId);
    }

    public void OnTap()
    {
        StartRoomDialogue();
    }
}
