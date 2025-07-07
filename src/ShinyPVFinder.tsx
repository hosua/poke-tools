import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import ListGroup from "react-bootstrap/ListGroup";
import Spinner from "react-bootstrap/Spinner";
import { Row, Col } from "react-bootstrap";

import toast from "react-hot-toast";

import "bootstrap/dist/css/bootstrap.min.css";

import { useState } from "react";

const NatureEnum = {
  0: "Hardy",
  1: "Lonely",
  2: "Brave",
  3: "Adamant",
  4: "Naughty",
  5: "Bold",
  6: "Docile",
  7: "Relaxed",
  8: "Impish",
  9: "Lax",
  10: "Timid",
  11: "Hasty",
  12: "Serious",
  13: "Jolly",
  14: "Naive",
  15: "Modest",
  16: "Mild",
  17: "Quiet",
  18: "Bashful",
  19: "Rash",
  20: "Calm",
  21: "Gentle",
  22: "Sassy",
  23: "Careful",
  24: "Quirky",
};

const findShinyPVs = async (trainerId, trainerSecretId) => {
  trainerId = parseInt(trainerId, 16);
  trainerSecretId = parseInt(trainerSecretId, 16);

  const results = {};

  for (let x = 0; x <= 0xffff; x++) {
    for (let i = 0; i < 8; i++) {
      const y = trainerId ^ trainerSecretId ^ x ^ i;
      if (y < 0 || y > 0xffff) continue;

      const pv = ((x << 16) | y) >>> 0; // >>> 0 will essentially make js treat this as an unsigned int
      const nature = NatureEnum[pv % 25];
      if (!(nature in results)) results[nature] = [];
      if (results[nature].length < 10) results[nature].push(pv); // limit to only the first 10 pvs we find
    }
  }
  return results;
};

const ShinyPVFinder = () => {
  const [input, setInput] = useState({
    trainerId: localStorage.getItem("trainer_id"),
    trainerSecretId: localStorage.getItem("trainer_secret_id"),
  });
  const [shinyPVs, setShinyPVs] = useState(null);
  const [loadingPVs, setLoadingPVs] = useState(false);

  return (
    <div>
      <Form.Group className="mx-5 mt-3 w-50">
        <Row>
          <Col>
            <Form.Label>Trainer ID (hexadecimal)</Form.Label>
            <Form.Control
              value={input.trainerId}
              maxLength={4}
              onChange={(e) => {
                const value = e.target.value
                  .toUpperCase()
                  .replace(/[^0-9A-F]/g, "")
                  .slice(0, 4);
                setInput({
                  ...input,
                  trainerId: value,
                });
                localStorage.setItem("trainer_id", value);
              }}
            />
          </Col>
          <Col>
            <Form.Label>Trainer Secret ID (hexadecimal)</Form.Label>
            <Form.Control
              value={input.trainerSecretId}
              maxLength={4}
              onChange={(e) => {
                const value = e.target.value
                  .toUpperCase()
                  .replace(/[^0-9A-F]/g, "")
                  .slice(0, 4);
                setInput({
                  ...input,
                  trainerSecretId: value,
                });
                localStorage.setItem("trainer_secret_id", value);
              }}
            />
          </Col>
          <Col className="d-flex align-items-end">
            <div>
              <Button
                onClick={async () => {
                  setLoadingPVs(true);
                  setTimeout(async () => {
                    const res = await findShinyPVs(
                      input.trainerId,
                      input.trainerSecretId,
                    );
                    setShinyPVs(res);
                    setLoadingPVs(false);
                  }, 10);
                }}
                variant="primary"
              >
                Find Shiny PVs
              </Button>
              <Button
                className="mx-2"
                variant="danger"
                onClick={() => setShinyPVs(null)}
              >
                Clear
              </Button>
            </div>
          </Col>
        </Row>
      </Form.Group>
      {loadingPVs ? (
        <div className="d-flex justify-content-center my-4">
          <Spinner animation="border" role="status" />
          <span className="visually-hidden">Loading...</span>
        </div>
      ) : (
        shinyPVs && (
          <Row
            className="mx-5 my-3"
            style={{ display: "flex", flexWrap: "wrap", gap: "1rem" }}
          >
            {Object.entries(shinyPVs).map(([nature, pvs]) => (
              <div
                key={nature}
                style={{ flex: "0 0 200px", minWidth: "200px" }}
              >
                <ListGroup as="ul">
                  <ListGroup.Item as="li" variant="info" className="fw-bold">
                    {nature}
                  </ListGroup.Item>
                  {pvs.map((pv) => {
                    const hexPV = pv
                      .toString(16)
                      .toUpperCase()
                      .padStart(8, "0");
                    return (
                      <ListGroup.Item
                        action
                        as="li"
                        key={`pv-${pv}`}
                        onClick={() => {
                          navigator.clipboard.writeText(hexPV);
                          toast.success(`${hexPV} copied to clipboard`);
                        }}
                        style={{ cursor: "pointer" }}
                      >
                        0x{hexPV}
                      </ListGroup.Item>
                    );
                  })}
                </ListGroup>
              </div>
            ))}
          </Row>
        )
      )}
    </div>
  );
};

export default ShinyPVFinder;
