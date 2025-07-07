import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import ListGroup from "react-bootstrap/ListGroup";
import Spinner from "react-bootstrap/Spinner";
import { Row, Col } from "react-bootstrap";

import ShinyPVFinder from "./ShinyPVFinder";

import { Toaster } from "react-hot-toast";

import "bootstrap/dist/css/bootstrap.min.css";

function App() {
  return (
    <div>
      <ShinyPVFinder />
      <Toaster
        toastOptions={{
          style: {
            borderRadius: "10px",
            background: "#333",
            color: "#fff",
          },
        }}
      />
    </div>
  );
}

export default App;
