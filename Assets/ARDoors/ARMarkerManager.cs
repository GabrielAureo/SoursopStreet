using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

//https://www.youtube.com/watch?v=I9j3MD7gS5Y
[RequireComponent(typeof(ARTrackedImageManager))]
public class ARMarkerManager : MonoBehaviour
{
    private ARTrackedImageManager trackedImageManager;
    [SerializeField] private List<GameObject> roomsPrefabs;

    private Dictionary<string, GameObject> instantiatedPrefabs = new Dictionary<string, GameObject>();

    private void Awake()
    {
        trackedImageManager = GetComponent<ARTrackedImageManager>();
    }
    void OnEnable() => trackedImageManager.trackedImagesChanged += OnChanged;

    void OnDisable() => trackedImageManager.trackedImagesChanged -= OnChanged;

    void OnChanged(ARTrackedImagesChangedEventArgs eventArgs)
    {
        foreach (var trackedImage in eventArgs.added)
        {
            var imageName = trackedImage.referenceImage.name;

            foreach (var curPrefab in roomsPrefabs)
            {
                if (string.Compare(curPrefab.name, imageName, StringComparison.Ordinal) == 0
                && !instantiatedPrefabs.ContainsKey(imageName))
                {
                    var newPrefab = Instantiate(curPrefab, trackedImage.transform);
                    instantiatedPrefabs[imageName] = newPrefab;
                }
            }
        }

        foreach (var trackedImage in eventArgs.updated)
        {
            instantiatedPrefabs[trackedImage.referenceImage.name]
            .SetActive(trackedImage.trackingState == TrackingState.Tracking);
        }

        foreach (var trackedImage in eventArgs.removed)
        {
            Destroy(instantiatedPrefabs[trackedImage.referenceImage.name]);
            instantiatedPrefabs.Remove(trackedImage.referenceImage.name);
        }
    }


}