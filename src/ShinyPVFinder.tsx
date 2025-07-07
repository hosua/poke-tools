import Form from "react-bootstrap/Form";
import Button from "react-bootstrap/Button";
import ListGroup from "react-bootstrap/ListGroup";
import Spinner from "react-bootstrap/Spinner";
import { Row, Col } from "react-bootstrap";

import toast from "react-hot-toast";

import "bootstrap/dist/css/bootstrap.min.css";

import { useState } from "react";

const Natures = [
  "Hardy",
  "Lonely",
  "Brave",
  "Adamant",
  "Naughty",
  "Bold",
  "Docile",
  "Relaxed",
  "Impish",
  "Lax",
  "Timid",
  "Hasty",
  "Serious",
  "Jolly",
  "Naive",
  "Modest",
  "Mild",
  "Quiet",
  "Bashful",
  "Rash",
  "Calm",
  "Gentle",
  "Sassy",
  "Careful",
  "Quirky",
] as const;

type Nature = (typeof Natures)[number];

const findShinyPVs = async (trainerId: string, trainerSecretId: string) => {
  const trainerIdVal = parseInt(trainerId, 16);
  const trainerSecretIdVal = parseInt(trainerSecretId, 16);

  const results: Record<Nature, number[]> = Natures.reduce(
    (acc, nature) => {
      acc[nature] = [];
      return acc;
    },
    {} as Record<Nature, number[]>,
  );

  for (let x = 0; x <= 0xffff; x++) {
    for (let i = 0; i < 8; i++) {
      const y = trainerIdVal ^ trainerSecretIdVal ^ x ^ i;
      if (y < 0 || y > 0xffff) continue;

      const pv = ((x << 16) | y) >>> 0; // >>> 0 will essentially make js treat this as an unsigned int
      const nature = Natures[pv % 25];
      if (results[nature].length < 10) results[nature].push(pv); // limit to only the first 10 pvs we find
    }
  }
  return results;
};

const ShinyPVFinder = () => {
  const [input, setInput] = useState({
    trainerId: localStorage.getItem("trainer_id") || "",
    trainerSecretId: localStorage.getItem("trainer_secret_id") || "",
  });
  const [shinyPVs, setShinyPVs] = useState<Partial<
    Record<Nature, number[]>
  > | null>(null);
  const [loadingPVs, setLoadingPVs] = useState(false);

  return (
    <div>
      <Form.Group className="mx-5 mt-3 w-50">
        <h3> Shiny PV Finder </h3>
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
