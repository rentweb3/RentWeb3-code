import {
  Box,
  Button,
  Center,
  Heading,
  Link,
  Text,
  VStack,
} from "@chakra-ui/react";
import React from "react";
import LinkButton from "../LinkButton/LinkButton";

function UnqiuenessCard(props) {
  let title = props.title;
  let description = props.description;
  let btnCaption = props.btnCaption;
  let btnHandler = props.btnHandler;
  let btnLink = props.btnLink;

  return (
    <VStack
      padding={"20px"}
      bg={"black"}
      height={"fit-content"}
      minH={"65vh"}
      width={"25vw"}
      minW={"300px"}
      color={"white"}
      border={"1px solid white"}
      borderRadius={"20px"}
      justify={"center"}
      spacing={5}
    >
      <Heading fontWeight={"700"} fontSize={"2rem"}>
        {title}
      </Heading>
      <Text padding={"20px"} fontSize={"1.2rem"}>
        {description}
      </Text>
      <Link href={btnLink ? btnLink : "#"}>
        <Button
          colorScheme={"linkedin"}
          onClick={btnHandler ? btnHandler : () => {}}
        >
          {btnCaption}
        </Button>
      </Link>
    </VStack>
  );
}

export default UnqiuenessCard;
