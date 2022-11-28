import { Img, Link, WrapItem } from "@chakra-ui/react";
import { transform } from "lodash";
import React from "react";

function PowerByEntry(props) {
  let img = props.img;
  let link = props.link;
  return (
    <WrapItem
      transition={"250ms all ease-in-out"}
      _hover={{
        transform: "scale(1.05)",
      }}
    >
      <Link href={link}>
        <Img
          height={"70px"}
          borderRadius={"10px"}
          width={"160px"}
          objectFit={"contain"}
          src={img}
          bg={"white"}
          paddingLeft={"10px"}
          paddingRight={"10px"}
        />
      </Link>
    </WrapItem>
  );
}

export default PowerByEntry;
