import React from "react";
import "./App.css";

const FAQList = ({faq, index, toggleFAQ}) => {
    return(
            
        <div
        className={"faq " + (faq.open ? "open" : "")}
        key={index}
        onClick={() => toggleFAQ(index)}
      >
        <div className="faq-question">{faq.question}</div>
        <div className="faq-answer">{faq.answer}</div>
      </div>
    );
  };
export default FAQList;