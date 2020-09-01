import React from "react";
import { shallow } from "enzyme";
import SeatsSelector  from "components/SeatsSelector";
import SeatsColumns from "components/SeatsColumns";

describe("Components", () => {
  describe("<SeatsSelector />", () => {
    const setup = (params) => {
      const wrapper = shallow(<SeatsSelector params={params} />);

      return {
        wrapper
      };
    };

    const params = {}
    const { wrapper } = setup(params);

    describe("children", () => {
      describe("<SeatsColumns />", () => {
        it("renders correctly", () => {
          const columns = wrapper.find(SeatsColumns);

          expect(columns).toHaveLength(1);
        });
      });

      describe("<ReloadButton />", () => {
        const reloadButton = wrapper.find("ReloadButton");

        it("renders correctly", () => {
          expect(reloadButton).toHaveLength(1);
        });

        it("has the correct content", () => {
          const text = "Create new Venue";

          expect(reloadButton.text()).toEqual(text);
        });
      });

      describe("<StageDiv />", () => {
        const stageDiv = wrapper.find("StageDiv");

        it("renders correctly", () => {
          expect(stageDiv).toHaveLength(1);
        });

        it("has the correct content", () => {
          const text = "STAGE";

          expect(stageDiv.text()).toEqual(text);
        });
      });
    });
  });
});
