 # Notes #

 - Connect to the Control Server `ssh user_name@users.deterlab.net`
 - Latency/Delay between nodes must be atleast 5ms
 - /project/pname and /home/uname are persistent across experients and nodes


 # Questions #
 - What does this mean?
    > Please don't use the Qualified Name from within nodes in your experiment, since it will contact them over the control network, bypassing the link shaping we configured.
