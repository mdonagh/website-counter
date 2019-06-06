Each time this page is loaded, it triggers a Delayed Job to redraw the counter based on the number of impressions recorded by the gem Impressionist. If there are multiple draw jobs in the queue, all jobs but the newest are deleted so that we don't waste time drawing and deleting the counter.

The drawing binary is triggered via a Faraday POST request. The binary is running in a detached one-off dyno on Heroku.

The number of views is capped at 9999, but it would be possible to dynamically resize the canvas to accommodate larger numbers.
