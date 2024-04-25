import './App.css';
import React, { useState } from "react";
import FAQList from './FAQList';

function FAQ() {
  const [faqs, setFaqs] = useState([
    {
      question: "What are Zomcakes?!",
      answer:
      "Zomcakes were created by mistake by the mysterious Kitty Baker by mixing regular ingredients with Dark Matter.",
      open: false
    },
    {
      question:"What is the Mint info?",
            answer: "Zomcakes are a supply of 7,000 evil baked goods. They are a free mint (just pay gas) available to the public on the 31st of October!  Whitelist mints will occur leading up to the 31st of october with premints revealing on halloween.",
              open: false
            },
            {
              question:"What is the zomcake utility?",
                          answwer:"Zomcakes have utility in Kitty World in that they provide Action Points to the owner. Zomcakes produce half the action points of cupcakes. Zomcakes can be cured to produce a cupcake by finding a potion nft.",
                open: false
              },   
              {
                question: "Where is the Zomcake discord?",
                         answer: "The Zomcake Discord can be found within the Kitty World Discord. Follow the official Kitty World Twitter for hints on how to gain access", 
                         open: false
                        },
                        {
                          question: "What are the Zomcakes official links?",
                          answer: "Opensea: TBA Discord: TBA Twitter: @0xZomcakes Twitter: @0xKittyWorld",
                          open: false
                        }
                      ]);

                        
                      const toggleFAQ = index => {
                        setFaqs(
                          faqs.map((faq, i) => {
                            if (i === index) {
                              faq.open = !faq.open;
                            } else {
                              faq.open = false;
                            }
                    
                            return faq;
                          })
                        );
                      };
                            return(
                              <div id = "faq">
                                <div className="container">
                                    <div className="row">
                                        <div className="col-sm-4">
                                        
                                        <div className="faqs">
                                        <center><h3>FAQS</h3></center>
        {faqs.map((faq, index) => (
          <FAQList faq={faq} index={index} key={index} toggleFAQ={toggleFAQ} />
        ))}
      </div></div>
                                    </div>
                                </div>
                                   </div>  
    );
        }
  export default FAQ;