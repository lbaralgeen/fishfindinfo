import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
    faTwitter,
  } from "@fortawesome/free-brands-svg-icons";

          {/* https://www.digitalocean.com/community/tutorials/creating-a-social-follow-component-in-react */}

export default function SocialFollow() {
  return (
    <div id="twit-content">
        Social Follow:&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="https://www.twitter.com/fishfindinfo" className="twitter social">
            <FontAwesomeIcon icon={faTwitter} size="1x" />
            </a>
    </div>
  );
}