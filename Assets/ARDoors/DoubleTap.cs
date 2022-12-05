using System;
using UnityEngine;

public class DoubleTapBehaviour
{
    private Action singleTapAction;
    private Action doubleTapAction;
    private bool hasSingleTap;

    private float lastTapTime;
    private const float doubleTapInterval = .4f;

    public DoubleTapBehaviour(Action doubleTapAction)
    {
        this.doubleTapAction = doubleTapAction;
        lastTapTime = 0f;

    }
    public DoubleTapBehaviour(Action sigleTapAction, Action doubleTapAction)
    {
        this.doubleTapAction = doubleTapAction;
        this.singleTapAction = sigleTapAction;
        this.hasSingleTap = true;
        lastTapTime = 0f;
    }

    public void Tap()
    {
        doSingleTap();
        if (isDoubleTap())
        {
            doDoubleTap();
        }

    }
    private void doSingleTap()
    {
        if (hasSingleTap)
            singleTapAction();
    }
    private bool isDoubleTap()
    {
        var timeSinceLastTap = Time.time - lastTapTime;
        lastTapTime = Time.time;
        return timeSinceLastTap < doubleTapInterval;
    }
    private void doDoubleTap()
    {
        doubleTapAction();
    }
}