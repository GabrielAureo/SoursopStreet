using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class DoorController : MonoBehaviour, ARInteractable
{
    private Animator animator;
    private AudioSource source;
    private DoubleTapBehaviour doubleTapBehaviour;
    public UnityEvent OnDoorOpen { get; private set; } = new UnityEvent();

    [SerializeField] private AudioClip KnockSound;

    private bool open;


    private void Awake()
    {
        animator = GetComponent<Animator>();
        source = GetComponent<AudioSource>();
        doubleTapBehaviour = new DoubleTapBehaviour(singleKnockAction, doubleKnockAction);
        open = false;
    }


    public void OnTap()
    {
        if (!open)
            doubleTapBehaviour.Tap();

    }

    private void singleKnockAction()
    {
        source.PlayOneShot(KnockSound);
    }

    private void doubleKnockAction()
    {
        Open();
    }

    public void Open()
    {
        animator.SetBool("Open", true);
        open = true;
        OnDoorOpen.Invoke();
    }
    public void Close()
    {
        animator.SetBool("Open", false);
        open = false;
    }

}
