using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ARTouchController : MonoBehaviour
{
    private void Update()
    {
#if UNITY_ANDROID && !UNITY_EDITOR
            
        if (Input.touchCount <= 0 || Input.GetTouch(0).phase != TouchPhase.Began) return;
        if (IsOverUI()) return;

        var ray = CameraRay();
        
#endif

        var input = Input.GetMouseButtonDown(0);
        //if (IsOverUI()) return;
        if (input)
        {
            var ray = CameraRay();
            HitTest(ray);
        }
    }

    private bool IsOverUI()
    {

#if UNITY_ANDROID && !UNITY_EDITOR
    var position = Input.GetTouch(0).position
#endif
        var position = Input.mousePosition;
        var eventDataCurrentPosition = new PointerEventData(EventSystem.current)
        {
            position = position
        };
        var results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(eventDataCurrentPosition, results);
        return results.Count > 0;
    }

    private void HitTest(Ray ray)
    {
        RaycastHit[] hits;
        hits = Physics.RaycastAll(ray);
        Debug.Log(hits);
        if (hits.Length > 0)
        {
            ARInteractable selectedInteractable = null;
            foreach (var hit in hits)
            {

                var interactable = hit.transform.GetComponent<ARInteractable>();
                if (interactable != null) selectedInteractable = interactable;

            }
            selectedInteractable.OnTap();

        }
    }

    private Ray CameraRay()
    {
        Vector2 inputPosition = Input.mousePosition;
#if UNITY_ANDROID && !UNITY_EDITOR
            inputPosition = Input.touches[0].position;
#endif
        var wrldPos = Camera.main.ScreenToWorldPoint(new Vector3(inputPosition.x, inputPosition.y, 1.35f));
        //Debug.Log(wrldPos);
        transform.position = new Vector3(wrldPos.x, wrldPos.y, wrldPos.z);
        Ray ray = Camera.main.ScreenPointToRay(inputPosition);
        return ray;

    }
}