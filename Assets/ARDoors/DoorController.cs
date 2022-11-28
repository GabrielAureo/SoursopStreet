using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class DoorController : MonoBehaviour, ARInteractable
{
    private Animator animator;
    private AudioSource source;
    private DoubleTapBehaviour doubleTapBehaviour;

    [SerializeField] private AudioClip KnockSound;


    private void Awake()
    {
        animator = GetComponent<Animator>();
        source = GetComponent<AudioSource>();
        doubleTapBehaviour = new DoubleTapBehaviour(singleKnockAction, doubleKnockAction);
    }


    public void OnTap()
    {
        Debug.Log("Tap");
        doubleTapBehaviour.Tap();

    }

    private void singleKnockAction()
    {
        source.PlayOneShot(KnockSound);
    }

    private void doubleKnockAction()
    {
        animator.SetTrigger("open");
    }

}
