import { Box, Center, Heading, Wrap, WrapItem, Img } from "@chakra-ui/react";
import React from "react";
import PowerByEntry from "./PowerByEntry";

function PoweredBy() {
  return (
    <Box bg={"black"}>
      <Center paddingTop={"10vh"}>
        <Heading color={"white"} fontSize={"3em"}>
          Powered By
        </Heading>
      </Center>
      <Wrap padding={"10vw"} paddingTop={"5vh"} spacing={10}>
        <PowerByEntry
          link={"https://learnweb3.io/"}
          img={"https://learnweb3.io/brand/logo-blue.png"}
        />
        <PowerByEntry
          link={"https://chain.link/"}
          img={
            "https://assets-global.website-files.com/5f6b7190899f41fb70882d08/5f760a499b56c47b8fa74fbb_chainlink-logo.svg"
          }
        />
        <PowerByEntry
          link={"https://polygon.technology/"}
          img={"https://learnweb3.io/logos/polygon-black.png"}
        />
        <PowerByEntry
          link={"https://filecoin.io/"}
          img={"https://docs.filecoin.io/logos/Filecoin-logo-blue+black.png"}
        />
        <PowerByEntry
          link={"https://tron.network/"}
          img={"https://miro.medium.com/max/1400/0*LqYCdN5Isj44q3fR.png"}
        />
        <PowerByEntry
          link={"https://ethereum.org/en/"}
          img={
            "http://cryptomining-blog.com/wp-content/uploads/2016/08/ethereum-logo.jpg"
          }
        />
        {/* <PowerByEntry  img={""}/>
        <PowerByEntry  img={""}/> */}
      </Wrap>
    </Box>
  );
}

export default PoweredBy;
