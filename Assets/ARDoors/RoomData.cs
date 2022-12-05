using System.Collections.Generic;
using UnityEngine;
[CreateAssetMenu(fileName = "RoomData", menuName = "ARDoors/RoomData", order = 0)]
public class RoomData : ScriptableObject
{
    public List<string> RoomOrder;

    public int GetRoomIndex(string roomId)
    {
        return RoomOrder.FindIndex((item) => item == roomId);
    }
}